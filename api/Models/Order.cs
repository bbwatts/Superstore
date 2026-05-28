public class Order
{
    public int OrderID { get; set; }
    public DateTime OrderDate { get; set; }
    public int customerID { get; set; }
    public decimal SalesPrice { get; set; }
    public int Inventory { get; set; }
    public decimal Discount { get; set; }
    public decimal Profit { get; set; }
    public int ShipModeID { get; set; }
    public DateTime Shipdate { get; set; }
}