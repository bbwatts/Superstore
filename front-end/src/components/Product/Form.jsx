import { useEffect, useState } from "react";
import { read } from "../../api/fetch-wrapper";

const emptyForm = {
  productName: "",
  categoryID: "",
  subCategoryID: "",
  unitPrice: "",
  quantity: "",
};

export default function ProductForm({ initialValues = emptyForm }) {
  const [form, setForm] = useState(initialValues);
  const [error, setError] = useState(null);
  const [submitting, setSubmitting] = useState(false);
  const [categories, setCategories] = useState([]);
  const [subCategories, setSubCategories] = useState([]);

  useEffect(() => {
    console.log("Fetching categories and subcategories...");
    const fetchCategories = async () => {
      try {
        const data = await read("categories");
        console.log("Fetched categories:", data);
        setCategories(data);
      } catch (err) {
        setError(err.message);
      }
    };

    const fetchSubCategories = async () => {
      try {
        const data = await read("subcategories");
        console.log("Fetched subcategories:", data);
        setSubCategories(data);
      } catch (err) {
        setError(err.message);
      }
    };

    fetchCategories();
    fetchSubCategories();
  }, []);

  return (
    <form>
      {error && <p style={{ color: "red" }}>{error}</p>}
      <div>
        <label for="categoryID">Category</label>
        <select name="categoryID" value={form.categoryID} required>
          <option value="">Select a category</option>
          {categories.map((category) => (
            <option key={category.categoryID} value={category.categoryID}>
              {category.categoryName}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label for="subCategoryID">Subcategory</label>
        <select name="subCategoryID" value={form.subCategoryID} required>
          <option value="">Select a subcategory</option>
          {subCategories.map((subCategory) => (
            <option
              key={subCategory.subCategoryID}
              value={subCategory.subCategoryID}
            >
              {subCategory.subCategoryName}
            </option>
          ))}
        </select>
      </div>
    </form>
  );
}