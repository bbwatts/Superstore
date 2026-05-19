import { useState, useEffect } from "react";
import { useParams} from "react-router";

export default function ProductDetail() {
    const { id } = useParams();
    console.log("Product ID:", id);


    return (
        <div>
            <h2>Detail Product</h2>
            <p>Product details will be displayed here.</p>
        </div>
    );
}