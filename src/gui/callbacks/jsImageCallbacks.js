var payload = [];
require(["dojo/on", "dojo/dom", "dojo/topic", "dojo/mouse"],
	function(on, dom, topic, mouse) {
        var myDiv = dom.byId("%s");
        var fakeButton = dom.byId("%s");

        topic.subscribe("sendToMATLAB", function(data){
            payload = data;
            fakeButton.click();
        });

        on(myDiv, "mousemove", function(evt){
           data = {action: "mousemove",
                    coord: [evt.clientX, evt.clientY]};
           topic.publish("sendToMATLAB", data);
        });

        // TODO: manage left/right/mousewheel click
        // See https://stackoverflow.com/questions/40354765/dojo-not-trapping-right-click-event
           on(myDiv, "mousedown", function(evt){
               data = {action: "mousedown",
                        coord: [evt.clientX, evt.clientY]};
               topic.publish("sendToMATLAB", data);
        });
});