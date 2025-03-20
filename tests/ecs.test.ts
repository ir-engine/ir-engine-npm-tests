import { describe, expect, it } from "vitest";

import { defineComponent } from "@ir-engine/ecs";
import { defineComponent as defineComponentNested } from "@ir-engine/ecs/src/ComponentFunctions";

describe("Hyperflux", () => {
  it("should define a component using top level import", () => {
    const component = defineComponent({ name: "MyComponent" });
    expect(component).toBeDefined();
  });

  it("should define a component using nested import", () => {
    const component = defineComponentNested({ name: "MyComponent" });
    expect(component).toBeDefined();
  });

  it("top level and nested imports should be same definition", () => {
    expect(defineComponent).toBe(defineComponentNested);
  });
});
