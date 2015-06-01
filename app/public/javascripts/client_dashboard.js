console.log("hello");
$( document ).ready(function() {
    $("#dashboard-info").append("<h1>Hello Jeff!</h1>");
    setInterval(getDashBoardInfo, 500);
});

function getDashBoardInfo() {
    $.getJSON("/dashboard_info.json")
        .then(function(sources){
            appendSources(sources);
        })
}

function appendSources(sources) {
    $("#dashboard-info").html("");
    sources.forEach(function(source) {
    var root_url = source.root_url
        $("#dashboard-info").append("<p>"+root_url+"</p>");
    })

}
