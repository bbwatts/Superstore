public class OrderDetail
{
    public Order Order { get; set; } = new Order();
    public List<Product> Product { get; set; } = new List<Product>();
}