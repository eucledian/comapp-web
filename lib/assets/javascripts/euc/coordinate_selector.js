/**
  * coordinate_selector.js v0.1.0
  * @name Urbanity Coordinate Selector
  * @author Joel Cano
  * @version 0.1.0
  * @description Provides a map interface. TODO full description
  */

(function($){

  /**
    * @class CoordinateSelector
    */
  // Constructor
  function CoordinateSelector(container, opts){
    var defaults = {
      namespace: 'location',
      separator: '_',
      hasGeofenceBuilder: false,
      geofenceBuilderOpts: {},
      fields: {
        map: 'lat_map',
        search: 'lat_search'
      },
      zoom :{
        start: 3,
        selected: 17
      },
      lat: 37.09024,
      lng: -95.71289100000001,
      element: null,
      marker: null
    };
    $.extend(this, defaults);
    if(typeof opts == 'object') $.extend(this, opts);
    this.$container = container;
    this.init();
    return this;
  };

  // Instance methods
  $.extend(CoordinateSelector.prototype, {
    init: function(){
      this.initFields();
      if(this.hasGeofenceBuilder) this.initGeofenceBuilder();
    },
    initFields: function(){
      this.$search = this.$container.find(this.getId('search'));
      this.$map = this.$container.find(this.getId('map'));
      this.$lat = this.$container.find('#' + this.namespace + '_lat');
      this.initLngField();
    },
    initLngField: function(){
      var lngField = this.$lat.clone(),
        name = lngField.attr('name'),
        id = lngField.attr('id')
      ;

      lngField.attr({
        name: name.replace('lat', 'lng'),
        id: id.replace('lat', 'lng')
      });
      lngField.insertAfter(this.$lat);
      this.$lng = lngField;
    },
    getId: function(field, fields){
      var id = this.namespace;
      var part = this.fields[field];
      if(fields) part = fields[field];
      return '#' + id + this.separator + part;
    },
    setLocation: function(location){
      if(location){
        this.map.setZoom(this.zoom.selected);
        this.map.setCenter(location);
        this.$lat.val(location.lat());
        this.$lng.val(location.lng());
        if(this.marker) this.marker.setMap(null);
        this.marker = new google.maps.Marker({
          position: location,
          map: this.map
        });
      }
      this.locationUpdate(location, this);
    },
    locationUpdate: function(location, selector){}, // Location Update Event
    initMap: function(){
      this.initCenter();
      this.map = new google.maps.Map(this.$map.get(0), {
        zoom: this.zoom.start,
        center: this.center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      });
      if(this.element){
        var location = new google.maps.LatLng(this.element.lat, this.element.lng);
        this.setLocation(location);
      }
    },
    initCenter: function(){
      this.center = new google.maps.LatLng(this.lat, this.lng);
    },
    initAutoComplete: function(){
      this.autocomplete = new google.maps.places.Autocomplete(this.$search.get(0));
      google.maps.event.addListener(this.autocomplete, 'place_changed', this.autoCompleteOnChange.bind(this));
    },
    autoCompleteOnChange: function(){
      var place = this.autocomplete.getPlace();
      this.setLocation(place.geometry.location);
    },
    initGeofenceBuilder: function(){
      this.geofenceBuilder = new GeofenceBuilder(this, this.geofenceBuilderOpts);
    },
    load: function(){
      this.initMap();
      this.initAutoComplete();
      if(this.hasGeofenceBuilder) this.geofenceBuilder.load();
    }
  });

  // Static methods
  // $.extend(CoordinateSelector, {});

  /**
    * @class GeofenceBuilder
    * @private
    */
  // Constructor
  function GeofenceBuilder(selector, opts){
    var defaults = {
      selector: selector,
      markerOpts: {
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35
      },
      modes: {
        circle: true,
        polygon: true,
        polygonCircle: false
      },
      type: {
        circle: 'circle',
        polygon: 'polygon'
      },
      circle: {
        sides: 15
      },
      fields: {
        geofence: 'geofence',
        geofence_type: 'geofence_type'
      }
    };
    $.extend(this, defaults, opts);
    this.init();
    return this;
  };

  // Instance Methods
  $.extend(GeofenceBuilder.prototype, {
    init: function(){
      this.initFields();
    },
    initFields: function(){
      this.$geofence = this.selector.$container.find(this.selector.getId('geofence', this.fields));
      this.$type = this.selector.$container.find(this.selector.getId('geofence_type', this.fields));
    },
    getDrawingModes: function(){
      var els = [];
      if(this.modes.circle) els.push(google.maps.drawing.OverlayType.CIRCLE);
      if(this.modes.polygon || this.modes.polygonCircle) els.push(google.maps.drawing.OverlayType.POLYGON);
      return els;
    },
    initDrawingManager: function(){
      var opts = {
        drawingControlOptions: {
          drawingMode: google.maps.drawing.OverlayType.MARKER,
          position: google.maps.ControlPosition.TOP_CENTER,
          drawingModes: this.getDrawingModes()
        }
      };
      this.manager = new google.maps.drawing.DrawingManager(opts);
      if(this.data) this.renderMapData();
      this.manager.setMap(this.selector.map);
      google.maps.event.addListener(this.manager, 'overlaycomplete', this.onShapeComplete.bind(this));
    },
    onShapeComplete: function(event){
      var types = google.maps.drawing.OverlayType;
      var overlay = event.overlay;
      this.reset();
      switch(event.type){
      case types.POLYGON:
        this.processPolygon(overlay);
        break;
      case types.CIRCLE:
        this.processCircle(overlay);
        break;
      }
      this.shape = overlay;
    },
    processPolygon: function(overlay){
      var overlayArray = overlay.getPath().getArray();
      var points = this.getPolygonPoints(overlayArray);
      this.setValue({ locations: points }, this.type.polygon);
    },
    processCircle: function(overlay){
      if(this.modes.polygonCircle) this.processGeofenceCircle(overlay);
      else this.processRadiusCircle(overlay);
    },
    processGeofenceCircle: function(overlay){
      var points = this.getCirclePoints(overlay.getCenter(), overlay.getRadius(), this.circle.sides);
      this.setValue({ locations: points }, this.type.polygon);
    },
    processRadiusCircle: function(overlay){
      var center = overlay.getCenter();
      var value = {
        radius: parseInt(overlay.getRadius()),
        location: {
          latitude: center.lat(),
          longitude: center.lng()
        }
      };
      this.setValue(value, this.type.circle);
    },
    getCirclePoints: function(center, radius, sides){
      var points = [];
      var step = 360 / sides;
      for(var i = 0; i < sides; ++i){
        var pos = google.maps.geometry.spherical.computeOffset(center, radius, step * i);
        points.push(this.getPoint(pos));
      }
      points.push(points[0]); // Close Polygon
      return points;
    },
    getPolygonPoints: function(points){
      var res = [];
      for(var i = 0; i < points.length; ++i){
        res.push(this.getPoint(points[i]));
      }
      res.push(res[0]); // google maps missing last marker to close polygon.
      return res;
    },
    getPoint: function(pos){
      return { latitude: pos.lat(), longitude: pos.lng() };
    },
    setValue: function(data, type){
      this.$geofence.val(JSON.stringify(data));
      this.$type.val(type);
    },
    reset: function(){
      if(this.shape) this.shape.setMap(null);
      if(this.$geofence && this.$type) this.setValue(null, null);
    },
    renderMapData: function(){
      var type = this.$type.val();
      var fence = this.$geofence.val();
      if(type && fence){
        fence = JSON.parse(fence);
        switch(type){
          case this.type.circle:
            this.renderCircle(fence);
          case this.type.polygon:
            this.renderPolygon(fence);
          break;
        }
      }
    },
    renderPolygon: function(data){
      var coordinates = [],
          locations = data.locations,
          location = locations[0],
          center =  new google.maps.LatLng(location.latitude, location.longitude)
      ;
      $.each(locations, function(key, coordinate){
        coordinates.push({ lng: coordinate.longitude, lat: coordinate.latitude });
      });
      this.selector.setLocation(center);
      this.shape = new google.maps.Polygon(
        $.extend(this.markerOpts, {
          paths: coordinates,
          map: this.selector.map
        })
      );
    },
    renderCircle: function(data){
      var location = data.location;
      var center =  new google.maps.LatLng(location.latitude, location.longitude);
      this.selector.setLocation(center);
      this.shape = new google.maps.Circle(
        $.extend(this.markerOpts, {
          map: this.selector.map,
          center: center,
          radius: data.radius
        })
      );
    },
    load: function(){
      this.initDrawingManager();
      this.renderMapData();
    }
  });

  // jQuery Plugin
  $.fn.coordinate_selector = function(opts){
    return this.each(function(){
      var $this = $(this);
      $this.data('euc.coordinate-selector', new CoordinateSelector($this, $.extend($this.data(), opts)));
    });
  };
})(jQuery);
