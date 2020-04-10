({
    handleClick : function(component, event, helper) {
        let msg = component.get("v.FirstName");
        if (msg == 'SEU NOME') {
            //alert("FUNCIONOU CARAMBA!!!!");
            component.set("v.FirstName", 'Olá, ' + msg + '!');
        }else{
            component.set("v.FirstName", 'SEU NOME');
        }
    },
    doInit : function(component, event, helper){
        let msg = component.get("v.FirstName");
        if(msg == null){
            component.set("v.FirstName", 'Olá!!!');
        }
        //alert("The component is initialized");
    }
})
