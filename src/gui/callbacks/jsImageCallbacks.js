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
           data = {action: "move",
                    coord: [evt.clientX, evt.clientY]};
           topic.publish("sendToMATLAB", data);
        });

    	on(myDiv, "mousedown", function(evt){
            if(mouse.isLeft(evt)) {
                data = {action: "leftclick",
                        coord: [evt.clientX, evt.clientY]};
            }else if(mouse.isRight(evt)) {
                data = {action: "rightclick",
                        coord: [evt.clientX, evt.clientY]};
            } else {
                data = {action: "otherclick",
                        coord: [evt.clientX, evt.clientY]};
            }

            topic.publish("sendToMATLAB", data);
        });
});