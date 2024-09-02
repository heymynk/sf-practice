/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/


// Q 12 0f 60 ----> When a case is inseted on any Account, put the latest case Number on the Account in Latest Case Intserted field.

trigger LatestCaseInserted on Case (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        LatestCaseInsertedHandler.handleLatestCaseInserted(Trigger.new);
    }
}
