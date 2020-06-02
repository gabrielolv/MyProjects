public class NewCaseListController {
    public List<Case> getNewCases(){
        List<Case> newCaseList = Database.query('SELECT Id, CaseNumber FROM Case WHERE Status = \'new\'');
        return newCaseList;
    }
}
