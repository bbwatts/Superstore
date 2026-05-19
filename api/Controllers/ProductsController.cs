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
    
    [HttpGet(Name = "GetProducts")]
    public async Task<IActionResult> Get()
    {
        try
        {
            var row = await _db.QuerySingleAsync("GetProducts");
            if (row == null)
            {
                return NotFound("No products found.");
            }

            Product product = MapToProduct(row);
            return Ok(product  );
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, "An error occurred while processing your request for all products.");
        }
    }

    [HttpGet("{id}", Name = "GetProductsByID")]
    public async Task<IActionResult> Get(int id)
    {
        try
        {
            var row = await _db.QuerySingleAsync("GetProductsByID", new SqlParameter { ParameterName = "@ProductID", Value = id });
            if (row == null)
            {
                return NotFound("Product not found.");
            }

            Product product = MapToProduct(row);
            return Ok(product);
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, "An error occurred while processing your request for the specified product.");
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
        Quantity = Convert.ToInt32(row["Quantity"])
    }
    ;
    [HttpPost(Name = "CreateProduct")]
    public async Task<IActionResult> Post(Product product)
    {
        try
        {
            var parameters = new[]
            {
                new SqlParameter { ParameterName = "@ProductName", Value = product.ProductName },
                new SqlParameter { ParameterName = "@CategoryID", Value = product.CategoryID },
                new SqlParameter { ParameterName = "@SubCategoryID", Value = product.SubCategoryID },
                new SqlParameter { ParameterName = "@UnitPrice", Value = product.UnitPrice },
                new SqlParameter { ParameterName = "@Quantity", Value = product.Quantity }
            };

            await _db.ExecuteAsync("CreateProduct", parameters);
            return Ok("Product created successfully.");
        }
        catch (Exception ex)
        {
            // Log the exception (not shown here)
            return StatusCode(500, "An error occurred while processing your request to create a product.");
        }
    }
}