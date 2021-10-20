public class InventaryResponseClass {

	public Integer statusCode;
	public Body body;

	public class Body {
		public List<Inventory> Inventory;
	}

	public class Inventory {
		public String name;
		public String ProductID;
		public Integer Quan;
		public Integer BlockedQuan;
	}

	
	public static InventaryResponseClass parse(String json) {
		return (InventaryResponseClass) System.JSON.deserialize(json, InventaryResponseClass.class);
	}
}