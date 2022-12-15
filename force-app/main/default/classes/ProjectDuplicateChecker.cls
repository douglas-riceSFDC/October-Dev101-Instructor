public with sharing class ProjectDuplicateChecker {

    @InvocableMethod(description='Returns dupe projects.' label='Dupe Project Check' category='Project')
    public static List<ProjectDuplicateOutput> checkForDuplicateProjects(List<ProjectDuplicateInput> projectIds) {
        String att = 'AT&T';
        List<Project__c> currentProjects = [SELECT Name
                                                FROM Project__c
                                                WHERE Name = :att
                                                LIMIT 1];

        List<ProjectDuplicateOutput> outputs = new List<ProjectDuplicateOutput>();
        List<Project__c> duplicateProjects = new List<Project__c>();
        if(currentProjects.size() > 0) {
            duplicateProjects = [SELECT Id, Name
                                    FROM Project__c
                                    WHERE Name = :currentProjects[0].Name
                                        AND Id != :currentProjects[0].Id];

            ProjectDuplicateOutput output = new ProjectDuplicateOutput();
            output.projects = duplicateProjects;
            outputs.add(output);
        }

        return outputs;
    }

    public class ProjectDuplicateInput {
        @AuraEnabled
        public String ProjectName {get; set;}

        @AuraEnabled
        public List<Account> AccountInput {get; set;}        
        
        List<ProjectDuplicateOutput> Outputs {get; set;}

        
        @AuraEnabled
        public Date todaysDate;
    }

    public class ProjectDuplicateOutput {
        @InvocableVariable
        public List<Project__c> projects;

        @InvocableVariable
        public List<Project_Assignment__c> projectsAssignments;

    }
}