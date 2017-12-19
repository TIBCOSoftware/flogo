(function(){
    var showCase = {
        filterElements : {
            all : $(".all"),
            activities : $(".activity"),
            triggers : $(".trigger"),
            apps : $(".app")
        },
        init : function () {
            showCase.addEvents();
        },
        addEvents : function () {
            showCase.filterElements.all.on("click",showCase.filter);
            showCase.filterElements.activities.on("click",showCase.filter);
            showCase.filterElements.triggers.on("click",showCase.filter);
            showCase.filterElements.apps.on("click",showCase.filter);
        },
        filter  :   function(ev){
            var c = $(ev.target).prop("class").split(" "),itemType;
            $(".selected").removeClass("selected");
            $(ev.target).addClass("selected");
            $(".card-main").hide();
            itemType = c.find(function(cls){
                return (cls.search(/activity|trigger|app/i) != -1);
            });
            itemType ? $(".card-main--"+itemType).show():$(".card-main").show();
        },
        filterByAll : function(e){
                // placeholder
        },
        filterByActivities : function(e){

        },
        filterByTriggers : function(e){

        },
        filterByApps : function(e){

        }
    };
    showCase.init();
}());