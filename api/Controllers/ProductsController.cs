using System.Data;
using api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly IDatabaseService _db;

    public ProductsController(IDatabaseService db)
    {
        _db = db;
    }
    
    [HttpGet(Name = "GetAllProducts")]
    public async Task<IActionResult> Get()
    {
        try
        {
            List<Dictionary<string, object?>> rows = await _db.QueryAsync("GetProducts");

            List<Product> products = rows.Select(MapToProduct).ToList();
            return Ok(products);
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, $"An error occurred while processing your request for all products: {ex.Message}");
        }
    }

    [HttpGet("{id}", Name = "GetProductById")]
    public async Task<IActionResult> Get(int id)
    {
        try
        {
            var row = await _db.QuerySingleAsync("GetProduct", new SqlParameter("@ProductID", id));
            if (row == null)
                return NotFound();

            Product product = MapToProduct(row);
            return Ok(product);
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, $"An error occurred while processing your request for the product: {ex.Message}");
        }
    }

    [HttpPost(Name = "CreateProduct")]
    public async Task<IActionResult> Post([FromBody] Product product)
    {
        try
        {
            var parameters = new[]
            {
                new SqlParameter("@ProductName", product.ProductName),
                new SqlParameter("@CategoryID", product.CategoryID),
                new SqlParameter("@SubCategoryID", product.SubCategoryID),
                new SqlParameter("@UnitPrice", product.UnitPrice),
                new SqlParameter("@Inventory", product.Inventory)
            };

            var row = await _db.QuerySingleAsync("CreateProduct", parameters);

            if (row == null)
                return StatusCode(500, "Failed to create the product.");

                Product createdProduct = MapToProduct(row);
            return CreatedAtRoute("GetProductById", new { id = createdProduct.ProductID }, createdProduct);
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, $"An error occurred while processing your request to create a product: {ex.Message}");
        }
    }

    [HttpPut("{id}", Name = "UpdateProduct")]
    public async Task<IActionResult> Put(int id, [FromBody] Product product)
    {
        try
        {
            var parameters = new[]
            {
                new SqlParameter("@ProductID", id),
                new SqlParameter("@ProductName", product.ProductName),
                new SqlParameter("@CategoryID", product.CategoryID),
                new SqlParameter("@SubCategoryID", product.SubCategoryID),
                new SqlParameter("@UnitPrice", product.UnitPrice),
                new SqlParameter("@Inventory", product.Inventory)
            };

            int newProductId = await _db.ExecuteAsync("UpdateProduct", parameters);
            return NoContent();
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, $"An error occurred while processing your request to update a product: {ex.Message}");
        }
    }

    [HttpDelete("{id}", Name = "DeleteProduct")]
    public async Task<IActionResult> Delete(int id, [FromQuery] bool permanent)
    {
        try
        {
            var parameters = new[]
            {
                new SqlParameter("@ProductID", id),
                new SqlParameter("@Delete", permanent)
            };

            await _db.ExecuteAsync("DeleteProduct", parameters);
            return NoContent();
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, $"An error occurred while processing your request to delete a product: {ex.Message}");
        }
    }

    private static Product MapToProduct(Dictionary<string, object?> row) => new Product
    {
        ProductID = Convert.ToInt32(row["ProductID"]),
        ProductName = Convert.ToString(row["ProductName"]) ?? string.Empty,
        CategoryID = Convert.ToInt32(row["CategoryID"]),
        SubCategoryID = Convert.ToInt32(row["SubCategoryID"]),
        Category = Convert.ToString(row["Category"]) ?? string.Empty,
        SubCategory = Convert.ToString(row["SubCategory"]) ?? string.Empty,
        UnitPrice = Convert.ToDecimal(row["UnitPrice"]),
        Inventory = Convert.ToInt32(row["Inventory"])
    };
}