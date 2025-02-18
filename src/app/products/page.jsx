'use client'
import React, { useState, useEffect, useCallback } from 'react'
import ListProductComponent from '../../components/product/ListProductComponent';
import { PAGINATION } from '../../utils/constant'
import * as _unitOfNetWork from '../../api'
import { Pagination, PaginationContent, PaginationItem, PaginationLink, PaginationNext, PaginationPrevious } from "@/components/ui/pagination";
import { useSearchParams } from 'next/navigation';
import NoResultComponent from '../../components/common/NoResultComponent'
export default function Page() {
    const searchParams = useSearchParams();
    const [pagination, setPagination] = useState({ ...PAGINATION });
    const [products, setProducts] = useState([]);
    const fetchProduct = useCallback(async () => {
        const categoryId = searchParams.get('categoryId');
        const brandId = searchParams.get('brandId');
        const search = searchParams.get("search");
        const res = await _unitOfNetWork.getSearchProducts({
            categoryId,
            brandId,
            productName: search,
            pagination,
        });

        if (res && res.code === 1) {
            setProducts(res.products);
            setPagination(() => ({
                ...res.pagination,
                totalPages: Math.ceil(res.pagination.total / res.pagination.limit),
            }));
        }
    }, [searchParams, pagination.page]);
    useEffect(() => {
        fetchProduct();
    }, [fetchProduct]);
    const handlePageChange = (page) => {
        if (page > 0 && page <= pagination.totalPages) {
            setPagination((prev) => ({ ...prev, page: page }));
        }
    };
    return (
        <div >
            <main className="p-4 ">
                {products.length == 0 ? (<NoResultComponent />) : (
                    <>
                        <ListProductComponent products={products} />
                        {/* Pagination */}
                        <div className="flex justify-center mt-8 flex-wrap gap-2">
                            <Pagination>
                                <PaginationContent>
                                    <PaginationItem>
                                        <PaginationPrevious
                                            onClick={() => handlePageChange(pagination.page - 1)}
                                            disabled={pagination.page === 1}
                                            className="mx-1 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
                                        />
                                    </PaginationItem>

                                    {Array.from({ length: pagination.totalPages }, (_, i) => i + 1)
                                        .filter((page) => {
                                            return (
                                                page === 1 ||
                                                page === pagination.totalPages ||
                                                (page >= pagination.page - 1 && page <= pagination.page + 1)
                                            );
                                        })
                                        .map((page, index, filteredPages) => {
                                            const shouldShowEllipsis =
                                                index > 0 && page - filteredPages[index - 1] > 1;

                                            return (
                                                <React.Fragment key={page}>
                                                    {shouldShowEllipsis && (
                                                        <PaginationItem>
                                                            <span className="mx-2">...</span>
                                                        </PaginationItem>
                                                    )}
                                                    <PaginationItem>
                                                        <PaginationLink
                                                            onClick={() => handlePageChange(page)}
                                                            className={`px-3 py-2 rounded-md transition-all text-sm sm:text-base ${pagination.page === page
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
                                            className="mx-1 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
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
