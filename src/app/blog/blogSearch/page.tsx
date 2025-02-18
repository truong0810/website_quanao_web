import BlogSeach from "@/module/blog/BlogSeach";

export default function page({ searchParams }) {
  const { query } = searchParams;

  return <BlogSeach query={query} />;
}
