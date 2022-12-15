public with sharing class LWCController {
    
    @AuraEnabled
    public static void apexCall(String input){
        try {
            input.Stage;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class JSONInput {
        @AuraEnabled
        List<JobStage> Stage {get; set;}

    }

    public class JobStage {
        @AuraEnabled
        String Name  {get; set;}

        @AuraEnabled
        List<InterviewQuestion> Questions  {get; set;}

        @AuraEnabled
        List<Interviews> Interviewers  {get; set;}
    }

    public class InterviewQuestion {
        @AuraEnabled
        Integer Index {get; set;}

        @AuraEnabled
        Interview_Question__c Question {get; set;}
    }
}
