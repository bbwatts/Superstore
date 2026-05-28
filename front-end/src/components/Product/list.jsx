import { useEffect, useState } from "react";
import { read, del} from "../../api/fetch-wrapper";
import { Link, useNavigate } from "react-router";

export default function ProductList() {
  const [products, setProducts] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    const fetchProducts = async () => {
      setLoading(true);
      try {
        const data = await read("products");
        setProducts(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  const handleDelete = async (productID) => {
    const proceed = window.confirm(
      "Are you sure you want to delete this product?"
    );

    if (!proceed) return;

    const permanent = window.confirm(
      "Click OK to permanently delete this product."
    );
    try {
      setDeleting(true);
      const res =await del(`products/${productID}?permanent=${permanent}`);
      if (res.ok) {
        navigate("/products");
      }
    }
    catch (err) {
      setError(err.message);
    }
    finally {
      setDeleting(false);
    }
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (products.length === 0) return <div>No products found.</div>;

  return (
    <div>
      <h2>Products</h2>
      <Link to={`/products/add`}>
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
                  <button onClick={() => handleDelete(product.productID)}>
                    {deleting ? "Deleting..." : "Delete"}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}