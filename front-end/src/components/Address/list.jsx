import { useEffect, useState } from "react";
import { read } from "../../api/fetch-wrapper";

export default function AddressList() {
    const [addresses, setAddresses] = useState([]);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchAddresses = async () => {
            setLoading(true);
            try {
                const data = await read("addresses");
                setAddresses(data);
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        fetchAddresses();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;
    if (addresses.length === 0) return <div>No addresses found.</div>;

    return (
        <div>
            <h2>Addresses</h2>
            <ul>
                {addresses.map((address) => (
                    <li key={address.addressID}>
                        {address.addressLine1}, {address.city}, {address.state} {address.postalCode}
                    </li>
                ))}
            </ul>
        </div>
    );
}