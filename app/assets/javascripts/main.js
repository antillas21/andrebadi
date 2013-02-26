    var HomeView = Backbone.View.extend({
        template: _.template($('#home').html()),

        render: function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    var AppRouter = Backbone.Router.extend({
        routes: { "": "home" },

        initialize: function () {
            $('.back').on('click', function(event) {
                window.history.back();
                return false;
            });

            this.firstPage = true;
        },

        home: function () {
            console.log('#home');
            this.changePage(new HomeView());
        },

        changePage: function (page) {
            $(page.el).attr('data-role', 'page');
            page.render();
            $('body').append($(page.el));
            var transition = $.mobile.defaultPageTransition;
            // We don't want to slide the first page
            if (this.firstPage) {
                transition = 'none';
                this.firstPage = false;
            }
            $.mobile.changePage($(page.el), {changeHash:false, transition: transition});
        }

    });

    $(document).ready(function () {
        console.log('document ready');
        app = new AppRouter();
        Backbone.history.start();
    });

