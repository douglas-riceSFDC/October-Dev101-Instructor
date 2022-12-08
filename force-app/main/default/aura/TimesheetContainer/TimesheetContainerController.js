({
    doInit : function(component, event, helper) {
        var projectId = component.get('v.recordId');

        console.log('aura project id: ');
        console.log(projectId);

        helper.getTimesheets(component, helper, projectId);
    }
})