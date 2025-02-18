'use client'
import React, { useState } from 'react'
import Image from 'next/image';
import parse from 'html-react-parser';
import defaultImage from '../../image/default_image.jpg'
export default function ProductTab({ product }) {
    const tabs = [
        { id: "description", label: "Mô tả" }
    ];
    const [activeTab, setActiveTab] = useState("description");
    const renderDescription = (description) => {
        if (typeof description !== 'string') {
            return <p>Không có mô tả</p>;
        }
        return parse(description, {
            replace: (domNode) => {
                if (domNode.name === 'img' && domNode.attribs.src) {
                    return (
                        <Image
                            src={domNode.attribs.src || defaultImage}
                            alt={domNode.attribs.alt || 'Product Image'}
                            width={500}
                            height={500}
                            className=""
                        />
                    );
                }
            },
        });
    };
    return (
        <div className="">
            <div className="flex space-x-8 border-b mb-5">
                {tabs.map((tab) => (
                    <button
                        key={tab.id}
                        onClick={() => setActiveTab(tab.id)}
                        className={`py-2  ${activeTab === tab.id ? "border-b-2 border-lime-600 text-lime-600" : "text-gray-600"}`}
                    >
                        {tab.label}
                    </button>
                ))}
            </div>
            <div className="py-4">
                {activeTab === "description" && (
                    <div>{renderDescription(product.description)}</div>
                )}
            </div>
        </div>
    )
}
