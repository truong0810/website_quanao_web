"use client";

import { Button } from "@/components/ui/button";
import { useEffect, useState } from "react";
import * as _unitOfWork from "../../api";

export default function BlogTag() {
  const [tags, setTags] = useState([]);

  useEffect(() => {
    fetchTags();
  }, []);

  const fetchTags = async () => {
    const res = await _unitOfWork.getAllTag();
    if (res && res.code === 1) {
      setTags(res.tags); // Đảm bảo res.tags là một mảng
    }
  };

  return (
    <>
      <span className="font-semibold text-start">Post Tags</span>
      <div className="flex flex-wrap gap-2 mt-2">
        {tags.length > 0 ? (
          tags.map((tag, index) => (
            <Button
              key={index}
              variant="secondary"
              className="hover:text-white hover:bg-black"
            >
              {tag.name}
            </Button>
          ))
        ) : (
          <span>Đang tải tags...</span>
        )}
      </div>
    </>
  );
}
