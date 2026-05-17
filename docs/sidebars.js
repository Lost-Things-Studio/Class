const sidebars = {
  docsSidebar: [
    "intro",
    "getting-started",
    {
      type: "category",
      label: "Guides",
      items: [
        "guides/classes",
        "guides/inheritance",
        "guides/private-state",
        "guides/debugging",
      ],
    },
    {
      type: "category",
      label: "API",
      items: [
        "api/class-factory",
        "api/helpers",
        "api/operators",
      ],
    },
    "testing",
    "contributing",
  ],
};

module.exports = sidebars;
