import { useState, useEffect } from "react";
import { read, del } from "../../api/fetch-wrapper";
import { Link, useNavigate, useParams } from "react-router";

export default function ProductDetail() {
  const { id } = useParams();
  const [product, setProduct] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();
  const [deleting, setDeleting] = useState(false);


  useEffect(() => {
    const fetchProduct = async () => {
      setLoading(true);
      try {
        const data = await read(`products/${id}`);
        setProduct(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchProduct();
  }, [id]);

  const handleDelete = async (productID) => {
    const proceed = window.confirm(
      "Are you sure you want to delete this product?",
    );

    if (!proceed) return;

    const permanent = window.confirm(
      "Click OK to permanently delete this product.",
    );

    try {
      setDeleting(true);
      const res = await del(`products/${productID}?permanent=${permanent}`);

      if (res.ok) {
        navigate("/products");
      }
    } catch (err) {
      setError(err.message);
    } finally {
      setDeleting(false);
    }
  };
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!product) return <div>No product found.</div>;

  return (
    <div>
      <h2>Product Details</h2>
      <Link to={`/products`}>
        <button>Back to Products</button>
      </Link>
      <table>
        <tbody>
          <tr>
            <td>
              <strong>Name:</strong>
            </td>
            <td>{product.productName}</td>
          </tr>
          <tr>
            <td>
              <strong>Price:</strong>
            </td>
            <td>${product.unitPrice.toFixed(2)}</td>
          </tr>
          <tr>
            <td>
              <strong>Category:</strong>
            </td>
            <td>{product.category}</td>
          </tr>
          <tr>
            <td>
              <strong>Sub-Category:</strong>
            </td>
            <td>{product.subCategory}</td>
          </tr>
          <tr>
            <td>
              <strong>Inventory:</strong>
            </td>
            <td>{product.inventory}</td>
          </tr>
        </tbody>
      </table>
      <div>
        <Link to={`/products/${product.productID}/edit`}>
          <button>Edit</button>
        </Link>
        <button onClick={() => handleDelete(product.productID)}>
          {deleting ? "Deleting..." : "Delete"}
        </button>
      </div>
    </div>
  );
}