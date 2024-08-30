/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class TaskTriggerHandler {
    public static void handleTaskPriority(List<Task> newTaskList){
        for (Task taskRec : newTaskList){
            System.debug('Task Record Found');
            taskRec.Priority = 'High';
        }
    }
}