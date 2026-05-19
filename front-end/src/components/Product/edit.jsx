import { useState } from "react";
import ProductForm from "./Form";

export default function ProductEdit() {
    const [initialValues, setInitialValues] = useState(null);

    return (
        <div>
            <h2>Edit Product</h2>
            <ProductForm />
        </div>
    );
}