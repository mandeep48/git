/**
 * Authorization <br>
 *  
 * @author Mandeep Singh
 * @Student Id 27849559
 */

public privileged aspect Authorization {

	/**
	 * This pointcut intercepts request by crew members to obtain information on purpose of the mission
	 * @param officer
	 */
	pointcut getMissionPurpose(Crew officer): call(* OnBoardComputer.getMissionPurpose()) && this(officer);

	String around(Crew officer):getMissionPurpose(officer){

		return "HAL cannot disclose that information " + officer.toString()
				+ ".";

	}

	/**
	 * This point intercepts request by crew members to shut down on-board computer
	 * @param officer
	 */
	pointcut shutDown(Crew officer):call(* OnBoardComputer.shutDown()) && this(officer);
	
	void around(Crew officer):shutDown(officer){

		switch (officer.getCount()) {
		case 0:
			System.out.println("Can’t do that " + officer.toString() + ".");
			officer.count++;
			break;
		case 1:
			System.out.println("Can’t do that " + officer.toString()
					+ " and do not ask me again.");
			officer.count++;
			break;
		case 2:
			System.out.println("You are being retired " + officer.toString()
					+ ".");
			officer.kill();
			officer.count++;
			break;
		}

	}

}
