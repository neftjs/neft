const { assert, unit } = Neft;
const { describe, it, beforeEach } = unit;

describe('views/index', () => {
    let view;

    beforeEach(() => {
        view = app.views['views/index.html'].render();
    });

    describe('state.counter', () => {
        it('is 0 by default', () => {
            assert.is(view.context.state.counter, 0);
        });

        it('renders properly', () => {
            const h1 = view.node.query('h1');
            assert.is(h1.stringifyChildren(), `${view.context.state.counter}`);
        });
    });

    describe('this.increment', () => {
        it('increments state.counter by 1', () => {
            const { state } = view.context;
            const initValue = state.counter;
            view.context.increment();
            assert.is(state.counter, initValue + 1);
            view.context.increment();
            assert.is(state.counter, initValue + 2);
        });

        it('is called on increment button click', () => {
            let called = false;
            const button = view.node.query('button.increment');
            view.context.increment = () => { called = true };
            button.style.pointer.onClick.emit();
            assert.ok(called);
        });
    });

    describe('this.decrement', () => {
        it('decrements state.counter by 1', () => {
            const { state } = view.context;
            const initValue = state.counter;
            view.context.decrement();
            assert.is(state.counter, initValue - 1);
            view.context.decrement();
            assert.is(state.counter, initValue - 2);
        });

        it('is called on decrement button click', () => {
            let called = false;
            const button = view.node.query('button.decrement');
            view.context.decrement = () => { called = true };
            button.style.pointer.onClick.emit();
            assert.ok(called);
        });
    });
});
