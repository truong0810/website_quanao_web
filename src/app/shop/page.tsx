import React from 'react'
import ShopContainer from './ShopContainer';
import * as _unitOfNetwork from '../../api';
async function fetchData() {
    const [categoriesRes, brandsRes] = await Promise.all([
        _unitOfNetwork.getAllCategory(), 
        _unitOfNetwork.getAllBrand(),   
    ]);
    if (categoriesRes && brandsRes) {
            return {
                categories: categoriesRes.categories, brands: brandsRes.brands
            }
    }
}
export default async function Page() {
    const { categories , brands  } = await fetchData();
    return (
        <ShopContainer categories={categories} brands={brands} />
    )
}
