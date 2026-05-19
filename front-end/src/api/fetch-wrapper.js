const BASE_API_URL = process.env.REACT_APP_BASE_API_URL;

export async function read(endpoint) {
  const response = await fetch(`${BASE_API_URL}/${endpoint}`);

  if (!response.ok) {
    return Promise.reject(
        new Error(`Failed to fetch data from ${endpoint}`)
    );
  }

  return response.json();
}