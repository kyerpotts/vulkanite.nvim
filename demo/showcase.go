package main

import (
	"context"
	"fmt"
	"time"
)

const defaultTimeout = 3 * time.Second

type Renderer interface {
	Render(context.Context) (string, error)
}

type Dashboard struct {
	Title   string
	Widgets []string
}

func (d *Dashboard) Render(ctx context.Context) (string, error) {
	select {
	case <-ctx.Done():
		return "", ctx.Err()
	default:
		return fmt.Sprintf("%s: %d widgets", d.Title, len(d.Widgets)), nil
	}
}

func main() {
	// Methods are upright while structs and interfaces remain italic.
	ctx, cancel := context.WithTimeout(context.Background(), defaultTimeout)
	defer cancel()

	dashboard := &Dashboard{Title: "Vulkanite", Widgets: []string{"git", "lsp"}}
	output, err := dashboard.Render(ctx)
	if err != nil {
		panic(err)
	}
	fmt.Println(output)
}
