'use client'
import React, { useEffect, useState } from 'react'
import ListProductComponent from '../../components/product/ListProductComponent';
import { PAGINATION } from '../../utils/constant'
import * as _unitOfNetWork from '../../api'
import NoResultComponent from '../../components/common/NoResultComponent';
import { Disclosure, DisclosureButton, DisclosurePanel } from '@headlessui/react';
import { Pagination, PaginationContent, PaginationItem, PaginationLink, PaginationNext, PaginationPrevious } from "@/components/ui/pagination";
export default function ShopContainer({ categories, brands }) {
    const [selectedBrands, setSelectedBrands] = useState([]);
    const [selectedCategories, setSelectedCategories] = useState([]);
    const [pagination, setPagination] = useState({ ...PAGINATION });
    const [products, setProducts] = useState([]);
    const [isCategoriesOpen, setIsCategoriesOpen] = useState(true);
    const [isBrandsOpen, setIsBrandsOpen] = useState(true);
    const fetchProduct = async () => {
        const res = await _unitOfNetWork.getListFilteredProduct({
            categories: selectedCategories,
            brands: selectedBrands,
            pagination: pagination,
        });

        if (res && res.code === 1) {
            setProducts(res.products);
            setPagination((prev) => ({
                ...prev,
                ...res.pagination,
                totalPages: Math.ceil(res.pagination.total / res.pagination.limit),
            }));
        }
    };
    useEffect(() => {
        fetchProduct();
    }, [selectedCategories, selectedBrands, pagination.page]);

    const onChangeFilterCategories = (e, item) => {
        setSelectedCategories(prev => {
            const updatedCategories = e.target.checked
                ? [...prev, item.id]
                : prev.filter(id => id !== item.id);
            setPagination(prev => ({ ...prev, page: 1 }));
            return updatedCategories;
        });
    };

    const onChangeFilterBrand = (e, item) => {
        setSelectedBrands(prev => {
            const updatedBrands = e.target.checked
                ? [...prev, item.id]
                : prev.filter(id => id !== item.id);
            setPagination(prev => ({ ...prev, page: 1 }));
            return updatedBrands;
        });
    };
    const handlePageChange = (page) => {
        if (page > 0 && page <= pagination.totalPages) {
            setPagination((prev) => ({ ...prev, page: page }));
        }
    };
    return (
        <div className="flex flex-col lg:flex-row py-7 gap-6 margin-main">
            {/* Sidebar */}
            <aside className="w-full lg:w-1/4 rounded-md">
                {/* Lọc theo Danh mục */}
                <Disclosure defaultOpen={isCategoriesOpen}>
                    {({ open }) => (
                        <div>
                            {/* Disclosure Button */}
                            <DisclosureButton className="w-full flex justify-between items-center py-2 px-3 bg-gray-200 rounded-md mb-2 text-lg font-bold">
                                Danh mục
                                <span>{open ? '-' : '+'}</span>
                            </DisclosureButton>

                            {/* Disclosure Panel */}
                            <DisclosurePanel className="mt-2">
                                <ul className="space-y-2 ml-2">
                                    {categories.map((item) => (
                                        <li key={item.id}>
                                            <label className="flex items-center">
                                                <input
                                                    type="checkbox"
                                                    className="mr-2"
                                                    checked={selectedCategories.includes(item.id)}
                                                    onChange={(e) => onChangeFilterCategories(e, item)}
                                                />
                                                {item.name}
                                            </label>
                                        </li>
                                    ))}
                                </ul>
                            </DisclosurePanel>
                        </div>
                    )}
                </Disclosure>

                {/* Lọc theo Thương hiệu */}
                <Disclosure defaultOpen={isBrandsOpen}>
                    {({ open }) => (
                        <div>
                            <DisclosureButton className="w-full flex justify-between items-center py-2 px-3 bg-gray-200 rounded-md mb-2 text-lg font-bold">
                                Thương hiệu
                                <span>{open ? '-' : '+'}</span>
                            </DisclosureButton>
                            <DisclosurePanel>
                                <ul className="space-y-2 ml-2">
                                    {brands.map((item) => (
                                        <li key={item.id}>
                                            <label className="flex items-center">
                                                <input
                                                    type="checkbox"
                                                    className="mr-2"
                                                    checked={selectedBrands.includes(item.id)}
                                                    onChange={(e) => onChangeFilterBrand(e, item)}
                                                />
                                                {item.name}
                                            </label>
                                        </li>
                                    ))}
                                </ul>
                            </DisclosurePanel>
                        </div>
                    )}
                </Disclosure>
            </aside>

            {/* Hiển thị sản phẩm */}
            <main className="w-full lg:w-3/4 p-2">
                {products.length === 0 ? (
                    <NoResultComponent />
                ) : (
                    <>
                        <ListProductComponent products={products} />
                        <div className="flex flex-wrap justify-center items-center mt-8 gap-3">
                            <Pagination>
                                <PaginationContent >
                                    <PaginationItem>
                                        <PaginationPrevious
                                            onClick={() => handlePageChange(pagination.page - 1)}
                                            disabled={pagination.page === 1}
                                            className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
                                        />
                                    </PaginationItem>

                                    {Array.from({ length: pagination.totalPages }, (_, i) => i + 1)
                                        .filter((page) => {
                                            // Hiển thị trang đầu, trang cuối, hoặc các trang xung quanh trang hiện tại
                                            return (
                                                page === 1 ||
                                                page === pagination.totalPages ||
                                                (page >= pagination.page - 1 && page <= pagination.page + 1)
                                            );
                                        })
                                        .map((page, index, filteredPages) => {
                                            // Kiểm tra nếu có khoảng cách giữa các trang để hiển thị "..."
                                            const shouldShowEllipsis =
                                                index > 0 &&
                                                page - filteredPages[index - 1] > 1;

                                            return (
                                                <React.Fragment key={page}>
                                                    {/* Hiển thị dấu "..." */}
                                                    {shouldShowEllipsis && (
                                                        <PaginationItem>
                                                            <span className="mx-2">...</span>
                                                        </PaginationItem>
                                                    )}

                                                    {/* Hiển thị số trang */}
                                                    <PaginationItem>
                                                        <PaginationLink
                                                            onClick={() => handlePageChange(page)}
                                                            className={`px-3 py-2 rounded-md transition-all ${pagination.page === page
                                                                ? "bg-black text-white"
                                                                : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                                                                }`}
                                                        >
                                                            {page}
                                                        </PaginationLink>
                                                    </PaginationItem>
                                                </React.Fragment>
                                            );
                                        })}

                                    <PaginationItem>
                                        <PaginationNext
                                            onClick={() => handlePageChange(pagination.page + 1)}
                                            disabled={pagination.page === pagination.totalPages}
                                            className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
                                        />
                                    </PaginationItem>
                                </PaginationContent>
                            </Pagination>
                        </div>
                    </>
                )}
            </main>
        </div>
    )
}
