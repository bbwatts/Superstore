import { BrowserRouter, Routes, Route, Link } from "react-router";
import "./App.css";
import AddressList from "./components/Address/list";
import ProductList from "./components/Product/list";
import ProductAdd from "./components/Product/add";
import ProductEdit from "./components/Product/edit";
import ProductDetail from "./components/Product/Detail";

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <header className="App-header">
          <nav>
            <Link to="/products">Products</Link> |
            <Link to="/addresses">Addresses</Link>
          </nav>
        </header>
        <main>
          <Routes>
            <Route path="/products" element={<ProductList />} />
            <Route path="/products/add" element={<ProductAdd />} />
            <Route path="/products/:id/edit" element={<ProductEdit />} />
            <Route path="/products/:id" element={<ProductDetail />} />
            <Route path="/addresses" element={<AddressList />} />
          </Routes> 
        </main>
      </div>
    </BrowserRouter>
  );
}

export default App;