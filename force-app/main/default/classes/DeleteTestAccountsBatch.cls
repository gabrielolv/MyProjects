public class DeleteTestAccountsBatch implements Database.batchable<integer>, Iterator<integer>, iterable<integer>{
	integer counter = 0;
	public iterator<integer> iterator(){
		return this;
	}
	public boolean hasnext(){
		return counter < 10; // number of batches to be started
	}
	public integer next(){
		return counter++;	
	}		
	public iterable<integer> start(database.batchablecontext context){
		return this;
	}
	public void execute(database.batchablecontext context, integer[] scope){
		//maximum DML per transaction is 1000, but smaller values could be necessary for performance
		List<Account> deleteAccountList = [SELECT Id FROM Account WHERE Name LIKE 'TESTE' LIMIT 1000];
		delete deleteAccountList;
	}
	public void finish(Database.batchablecontext context){
		
	}		
}