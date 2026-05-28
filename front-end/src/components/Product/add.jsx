import ProductForm from "./Form";
import { create } from "../../api/fetch-wrapper";
import { useNavigate } from "react-router";

export default function ProductAdd() {

    const navigate = useNavigate();
    const handleSubmit = async (productData) => {
        const newProduct = await create("products", productData);

        navigate(`/products/${newProduct.productID}`);

    };
    return (
        <div>
            <h2>Add Product</h2>
            <productForm onSubmit={handleSubmit} />
        </div>
    );
}