public with sharing class TimesheetReminderGenerator {
    public static void sampleApexInput(Map<Id, Integer> input) {
        System.debug(input);
    }
    
    public static void queueReminderCreation(List<Timesheet__c> insertedTimesheets) {
        List<Id> timesheetIds = new List<Id>();
        for(Timesheet__c t : insertedTimesheets) {
            timesheetIds.add(t.Id);
        }

        //sendTimesheetSubmissionReminder(timesheetIds);
    }

    public static void sendTimesheetSubmissionReminder(List<Timesheet__c> insertedTimesheets) {
        System.debug('Start of Method!');
        // List<Timesheet__c> insertedTimesheets = [SELECT Id
        //                                     FROM Timesheet__c
        //                                     WHERE Id IN :insertedTimesheetIds];

        List<Task> generatedReminders = new List<Task>();

        for(Timesheet__c timesheet : insertedTimesheets) {
            Task reminder = new Task();
            reminder.Subject = 'Reminder: Submit your timesheet!!';
            reminder.WhatId = timesheet.Id;
            reminder.ActivityDate = Date.today().addDays(5);

            generatedReminders.add(reminder);
            
        }
        
        System.debug('After reminder generation - ' + generatedReminders);

        try {
            insert generatedReminders;
        } catch (System.DmlException e) {
            throw new System.DmlException(e.getMessage());
        } catch (Exception e) {

        }
    }
}