trigger Timesheet on Timesheet__c (before update, after insert) {

    if(Trigger.isBefore && Trigger.isUpdate) {
        TimesheetRejectionCounter.updateTimesRejectedOnRejection(Trigger.new, Trigger.oldMap);

    } else if(Trigger.isAfter && Trigger.isInsert) {
        TimesheetReminderGenerator.sendTimesheetSubmissionReminder(Trigger.new);

    }
    
}