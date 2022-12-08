public with sharing class TimesheetRejectionCounter {

    public static void updateTimesRejectedOnRejection(List<Timesheet__c> updatedTimesheets,
                                                        Map<Id, Timesheet__c> oldTimesheetMap) {

        for(Timesheet__c timesheet : updatedTimesheets) {
            if(timesheet.Status__c == 'Rejected' &&
                oldTimesheetMap.get(timesheet.Id).Status__c != timesheet.Status__c) {

                if(timesheet.Number_of_Times_Rejected__c == null) {
                    timesheet.Number_of_Times_Rejected__c = 0;
                }
                
                timesheet.Number_of_Times_Rejected__c = timesheet.Number_of_Times_Rejected__c + 1;
            }
        }
    }
}