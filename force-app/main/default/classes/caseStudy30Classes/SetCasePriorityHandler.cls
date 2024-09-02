/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class SetCasePriorityHandler {
    public static void handleTaskPriority(List<Case> newCase){
        for(Case caseRec : newCase){
            if (caseRec.Origin == 'Phone'){
                caseRec.Priority = 'High';
            }else{
                caseRec.Priority = 'Low';
            }
        }
    }
}