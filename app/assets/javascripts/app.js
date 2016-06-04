(function($){
  $(function(){
    var app = window.app = {};
    $.extend(app, {
      root: app,
      _window: null,
      init: function(){
        this.initWindow();
        this.circles = $('.slide-circle');
        this.renderCircles();
        this.resize(this.windowOnResize.bind(this));
        this.initNavigationLinks();
      },
      initNavigationLinks: function(){
        $('a[href*="#"]').click(this.navigationLinkOnClick);
      },
      navigationLinkOnClick: function(e){
        var href = $(this).attr('href');
        $(window).scrollTo(href, 500);
        window.location = href;
        e.preventDefault();
      },
      windowOnResize: function(){
        this.renderCircles();
      },
      renderCircles: function(){
        this.circles.each(this.renderCircle.bind(this));
      },
      renderCircle: function(key, circleDom){
        var circle = $(circleDom);
        var width = circle.outerWidth();
        circle.css('height', width);
      },
      initWindow: function(){
        this._window = $(window);
      },
      resize: function(callback){
        if(this.has_touch){
          window.addEventListener('orientationchange', callback, false);
        }
        else{
          this._window.resize(callback);
        }
      }
    });
    app.init();
  });
})(jQuery);
