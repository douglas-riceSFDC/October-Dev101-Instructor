({
    getTimesheets : function(component, helper, projectId) {
        var action = component.get('c.getTimesheetsByProject');

        action.setParams({
            projectId: projectId
        });

        action.setCallback(this, function (response) {
            if(response.getState() === 'SUCCESS') {
                var timesheets = response.getReturnValue();

                component.set('v.timesheets', timesheets);

                console.log(timesheets);
            }
            else {
                console.warn(response.getError());
            }
        });

        $A.enqueueAction(action);
    }
})