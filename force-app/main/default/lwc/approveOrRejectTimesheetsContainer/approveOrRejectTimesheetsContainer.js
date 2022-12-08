import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getTimesheetsByProject from '@salesforce/apex/ApproveOrRejectTimesheetsController.getTimesheetsByProject';
import approveOrRejectTimesheets from '@salesforce/apex/ApproveOrRejectTimesheetsController.approveOrRejectTimesheets';

export default class ApproveOrRejectTimesheetsContainer extends LightningElement {
    @api recordId;
    @api buttonVariant;

    timesheets;
    wiredTimesheetResponse;

    @wire(getTimesheetsByProject, { projectId: '$recordId' })
    wiredTimesheets(value) {
        this.wiredTimesheetResponse = value;

        console.log(value);

        if(value.data) {
            // this.timesheets = value.data.map(timesheet => {
            //     timesheet.EmployeeName = timesheet.Employee__r.Name;
            //     return timesheet;
            // });
            this.timesheets = value.data;
        }
        if(value.error) {
            console.warn(value.error);
        }
    }

    connectedCallback() {}

    handleTimesheets(event) {
        let timesheetParams = {
            timesheets: event.detail.timesheets,
            operation: event.detail.operation
        };

        approveOrRejectTimesheets(timesheetParams)
            .then(response => {
                this.showNotification('Success', 'Timesheets successfully ' + timesheetParams.operation.toLowerCase() + '.');
                
                refreshApex(this.wiredTimesheetResponse);
            })
            .catch(error => {
                console.warn(error);
                this.showNotification('Error', 
                    'There was an issue saving timesheets. Please contact an administrator.',
                    'error'
                );
            });
    }

    showNotification(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title: title,
            message: message,
            variant: variant || 'success'
        }));
    }
}