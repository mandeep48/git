/**
 * LifeSupport <br>
 *  
 * @author Mandeep Singh
 * @Student Id 27849559
 * 
 */

public aspect LifeSupport  {
	
	//To maintain the status of Crew Member
	private String Crew.status = "ALIVE";
	
	//To maintain the count of shut down method
	private int Crew.count =0;
	
	/**
	 * Method to get Life Status of Crew Member
	 * @return String
	 */
	private String Crew.getLifeStatus(){
		return this.status;
	}
	
	/**
	 * Method to get count of shut down
	 * @return
	 */
	private int Crew.getCount(){
		return this.count;
	}
	
	/**
	 * Method to kill the Crew Member
	 */
	private void Crew.kill() {
		if (this.count == 2) {
			this.status = "DEAD";
		}
	}
	
	/**
	 * Method to intercept all messages sent to on-board Computer by crew memeber 
	 * and perform filtering
	 * @param officer
	 */
	Object around(Crew officer) : call(* OnBoardComputer.*(..)) && this(officer) {

		if ("DEAD".equalsIgnoreCase(officer.getLifeStatus())) {
			return "";
		} else {
			return proceed(officer);
		}

	}

}
	
	
	

	
	
	
	
