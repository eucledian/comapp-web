var app = {};
$.extend(app, {
  root: null,
  _window: null,
  main_loader: null,
  has_touch: false,
  loading_count: 0,
  body: null,
  viewport: null,
  google_maps_loader: null,
  init: function(){
    this.initRoot();
    this.initGoogleMapsLoader();
  },
  initRoot: function(){
    this.root = this;
  },
  click: function(container, callback, stop, prevent){
    if(stop == null) stop = false;
    if(prevent == null) prevent = true;
    if(this.has_touch){
      app.addClickHandler(container, callback, stop, prevent);
    }
    else{
      container.click(function(e){
        if(prevent) e.preventDefault();
        if(stop) e.stopPropagation();
        callback(e, container);
      });
    }
  },
  initGoogleMapsLoader: function(){
    this.google_maps_loader = {};
    $.extend(this.google_maps_loader, {
      callbacks: [],
      added: false,
      head: null,
      loaded: false,
      init: function(){
        this.initHead();
      },
      initHead: function(){
        this.head = $('head');
      },
      load: function(callback, key){
        if(!this.loaded){
          if(!this.added) this.add(key);
          this.callbacks.push(callback);
        }else callback();
      },
      add: function(key){
        var url = '';
        url += 'http://maps.google.com/maps/api/js?';
        if(key) url += 'key=' + key + '&';
        url += 'callback=googleMapsOnLoad&';
        url += 'libraries=drawing,geometry,places&';
        url += 'region=MX';
        var script = $('<script></script>').attr({
          type: 'text/javascript',
          src: url
        });
        script.appendTo(this.head);
        this.added = true;
      },
      onLoad: function(){
        this.loaded = true;
        $.each(this.callbacks, function(key, callback){
          callback();
        });
        this.callbacks = [];
      }
    });
    this.google_maps_loader.init();
  },
  getTouchOpts: function(){
    var _self = this;
    return {
      body: this.body,
      has_touch: this.has_touch,
      _window: this._window,
      click: this.click,
      resize: this.resize,
      scroll: this.scroll,
      viewport: this.viewport,
      hasTouch: this.has_touch
    };
  }
});
(function(){
  $(function(){
    app.init();
  });
})(jQuery);

function googleMapsOnLoad(){
  app.google_maps_loader.onLoad();
}
