import { useState } from "react";
import ProductForm from "./Form";
import { useState, useEffect } from "react";
import { read} from "../../api/fetch-wrapper";
import { useNavigate, useParams } from "react-router";

export default function ProductEdit() {
    const [ id ] = useParams();
    const [initialValues, setInitialValues] = useState(null);
    const navigate = useNavigate();
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        useEffect(() => {
            const fetchProduct = async () => {
              setLoading(true);
              try {
                const data = await read(`products/${id}`);
                setInitialValues( {
                    productName: data.productName,
                    categoryID: data.categoryID,
                    subCategoryID: data.subCategoryID,
                    unitPrice: data.unitPrice,
                    inventory: data.inventory
                });
            
              } catch (err) {
                setError(err.message);
              } finally {
                setLoading(false);
              }
            };
        
            fetchProduct();
          }, [id]);

          const handleUpdate = async (updatedData) => {
            await update(`products/${id}`, updatedData);
            navigate(`/products/${id}`);
          }

          if (loading) return <div>Loading...</div>;
          if (error) return <div>Error: {error}</div>;

    return (
        <div>
            <h2>Edit Product</h2>
            <ProductForm initialValues={initialValues} onSubmit={handleUpdate} />
        </div>
    );
}