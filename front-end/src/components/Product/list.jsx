import { useEffect, useState } from "react";
import { read } from "../../api/fetch-wrapper";
import { Link } from "react-router";

export default function ProductList() {
  const [products, setProducts] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProducts = async () => {
      setLoading(true);
      try {
        const data = await read("Products");
        setProducts(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  const handleDelete = async (productId) => {
    console.log(`Delete product with ID: ${productId}`);
    // Implement delete functionality here
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (products.length === 0) return <div>No products found.</div>;

  return (
    <div>
      <h2>Products</h2>
      <Link to={'/products/add'}>
        <button>Add Product</button>
      </Link>
      {products.length === 0 ? (
        <p>No products found.</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>Price</th>
              <th>Category</th>
              <th>Sub-Category</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product) => (
              <tr key={product.productID}>
                <td>
                  <Link to={`/products/${product.productID}`}>
                    {product.productName}
                  </Link>
                </td>
                <td>${product.unitPrice.toFixed(2)}</td>
                <td>{product.category}</td>
                <td>{product.subCategory}</td>
                <td>
                  <Link to={`/products/${product.productID}/edit`}>
                    <button>Edit</button>
                  </Link>
                  <button onClick={() => handleDelete(product.productID)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}