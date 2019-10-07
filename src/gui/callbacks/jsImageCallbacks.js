var payload = [];
require(["dojo/on", "dojo/dom", "dojo/topic", "dojo/mouse"],
	function(on, dom, topic, mouse) {
        var myDiv = dom.byId("%s");
        var fakeButton = dom.byId("%s");

        topic.subscribe("sendToMATLAB", function(data){
            payload = data;
            fakeButton.click();
        });

        on(myDiv, "mouseup", function(evt){
            data = {action: "mouseup",
                    coord: [evt.offsetX, evt.offsetY]};
            topic.publish("sendToMATLAB", data);
        });

        on(myDiv, "mousedown", function(evt){
            if(mouse.isLeft(evt)) {
                data = {action: "leftclick",
                        coord: [evt.offsetX, evt.offsetY]};
            } else if(mouse.isRight(evt)) {
                data = {action: "rightclick",
                        coord: [evt.offsetX, evt.offsetY]};
            } else {
                data = {action: "otherclick",
                        coord: [evt.offsetX, evt.offsetY]};
            }

            topic.publish("sendToMATLAB", data);
        });

        on(myDiv, "mousemove", function(evt){
           data = {action: "move",
                    coord: [evt.offsetX, evt.offsetY]};
           topic.publish("sendToMATLAB", data);
        });
});