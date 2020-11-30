(function(){
    var showCase = {
        filterElements : {
            all : $(".all"),
            activities : $(".activity"),
            triggers : $(".trigger"),
            apps : $(".app"),
            search : $("#search")
        },
        debounceTime : 350, //milliseconds
        init : function () {
            showCase.addEvents();
        },
        addEvents : function () {
            showCase.filterElements.all.on("click",showCase.filter);
            showCase.filterElements.activities.on("click",showCase.filter);
            showCase.filterElements.triggers.on("click",showCase.filter);
            showCase.filterElements.apps.on("click",showCase.filter);
            showCase.filterElements.search.on("keyup",function(e){
                showCase.debounce(showCase.searchHandler, showCase.debounceTime)();
            });

        },
        searchHandler : function(){
            var cardType = $(".selected").prop("class").split(" ").find(function(cls){
                return (cls.search(/activity|trigger|app/i) != -1);
            }),cards,searchInput,name,description,author;
            if(cardType){
                cards = $(".card-main--"+cardType);
            }else{
                cards = $(".card-main");
            }
            searchInput = showCase.filterElements.search.val();
            //  console.log(searchInput);
            if(searchInput){
                searchInput = searchInput.toLowerCase();
                $.each(cards,function(i,el){
                    name = $(el).data("name");
                    author = $(el).data("author");
                    description = $(el).data("description");
                    if((name.toLowerCase().indexOf(searchInput) != -1) || (author.toLowerCase().indexOf(searchInput) != -1) || (description.toLowerCase().indexOf(searchInput) != -1) ){
                        $(el).show();
                    }else{
                        $(el).hide();
                    }
                });
            }else{
                $(cards).show();
            }

        },
        filter  :   function(ev){
            debugger;
            var c = $(ev.currentTarget).prop("class").split(" "),itemType;
            $(".selected").removeClass("selected");
            $(ev.currentTarget).addClass("selected");
            $(".card-main").hide();
            itemType = c.find(function(cls){
                return (cls.search(/activity|trigger|app/i) != -1);
            });
            itemType ? $(".card-main--"+itemType).show():$(".card-main").show();
        },
        debounce : function (func, wait, immediate) {
            var timeout;
            return function() {
                var context = this, args = arguments;
                var later = function() {
                    timeout = null;
                    if (!immediate) func.apply(context, args);
                };
                var callNow = immediate && !timeout;
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
                if (callNow) func.apply(context, args);
            };
        }
    };
    showCase.init();
}());