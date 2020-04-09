({
    handleClick : function(component, event, helper) {
        var msg = component.get("v.FirstName");
        if (msg == 'SEU NOME') {
            //alert("FUNCIONOU CARAMBA!!!!");
            component.set("v.FirstName", 'Olá, ' + msg + '!');
        }else{
            component.set("v.FirstName", 'SEU NOME');
        }
    },
    doInit : function(component, event, helper){
        alert("The component is initialized");
    }
})
