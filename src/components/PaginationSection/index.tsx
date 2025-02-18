"use client";
import React from "react";
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from "@/components/ui/pagination";

export default function PaginationCus({ pagination, onPageChange }) {
  const totalPages = Math.ceil(pagination.total / pagination.limit);

  return (
    <div className="flex justify-center mt-8 mb-[6vh]">
      <Pagination>
        <PaginationContent>
          <PaginationItem>
            {pagination.page === 1 ? (
              <span className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md cursor-not-allowed">
               Trước
              </span>
            ) : (
              <PaginationPrevious
                onClick={() => onPageChange(pagination.page - 1)}
                className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
              />
            )}
          </PaginationItem>

          {Array.from({ length: totalPages }, (_, i) => i + 1)
            .filter((page) => {
              // Display the first page, last page, or pages around the current page
              return (
                page === 1 ||
                page === totalPages ||
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
                      onClick={() => onPageChange(page)}
                      className={`px-3 py-2 rounded-md transition-all ${
                        pagination.page === page
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
            {pagination.page === totalPages ? (
              <span className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md cursor-not-allowed">
                Sau
              </span>
            ) : (
              <PaginationNext
                onClick={() => onPageChange(pagination.page + 1)}
                className="mx-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all"
              />
            )}
          </PaginationItem>
        </PaginationContent>
      </Pagination>
    </div>
  );
}
