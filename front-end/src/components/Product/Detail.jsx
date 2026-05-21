import { useState, useEffect } from "react";
import { useParams} from "react-router";
import { read } from "../../api/fetch-wrapper";
import { Link } from "react-router";

export default function ProductDetail() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

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

        if (loading) return <div>Loading...</div>;
        if (error) return <div>Error: {error}</div>;
        if (!product) return <div>No product found.</div>;


    return (
        <div>
            <h2> Product Details </h2>
            <Link to="/products">
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
                            <strong>Quantity:</strong>
                        </td>
                        <td>{product.quantity}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
}