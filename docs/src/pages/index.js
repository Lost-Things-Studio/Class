import Link from "@docusaurus/Link";
import Layout from "@theme/Layout";
import styles from "./index.module.css";

const highlights = [
  {
    title: "Small by design",
    text: "One Lua file, no runtime dependency, and an API that stays easy to embed.",
  },
  {
    title: "Class essentials",
    text: "Create classes, initialize instances, include behavior, and keep state private.",
  },
  {
    title: "Tested behavior",
    text: "The documented core behavior is covered by a Lua test suite and CI workflow.",
  },
];

export default function Home() {
  return (
    <Layout
      title="Class"
      description="Documentation for Class, a lightweight OOP helper for Lua."
    >
      <header className={styles.masthead}>
        <p className={styles.kicker}>Lua OOP helper</p>
        <h1>Class</h1>
        <p className={styles.lead}>
          A lightweight object-oriented helper for Lua projects that need
          classes, inheritance, private state, and a compact API.
        </p>
        <div className={styles.actions}>
          <Link className="button button--primary button--lg" to="/getting-started">
            Get Started
          </Link>
          <Link className="button button--secondary button--lg" to="/api/class-factory">
            API Reference
          </Link>
        </div>
      </header>

      <main>
        <section className={styles.highlights}>
          {highlights.map((item) => (
            <article className={styles.highlight} key={item.title}>
              <h2>{item.title}</h2>
              <p>{item.text}</p>
            </article>
          ))}
        </section>
      </main>
    </Layout>
  );
}
